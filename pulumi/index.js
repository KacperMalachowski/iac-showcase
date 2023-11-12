"use strict";
const pulumi = require("@pulumi/pulumi");
const gcp = require("@pulumi/gcp");

// Create a GCP resource (Storage Bucket)
const bucket = new gcp.storage.Bucket("my-bucket", {
  location: "EU",
  website: {
    mainPageSuffix: "index.html",
    notFoundPage: "404.html"
  },
  uniformBucketLevelAccess: true
});

const mainPage = new gcp.storage.BucketObject("main-page", {
  bucket: bucket.name,
  name: "index.html",
  source: new pulumi.asset.FileAsset("../app/index.html")
})

const notFoundPage = new gcp.storage.BucketObject("no-found-page", {
  bucket: bucket.name,
  name: "404.html",
  source: new pulumi.asset.FileAsset("../app/404.html"),

})

const bucketIamBindig = new gcp.storage.BucketIAMBinding("bucket-iam-bindig", {
  bucket: bucket.name,
  role: "roles/storage.objectViewer",
  members: ["allUsers"]
})

// Export the DNS name of the bucket
exports.mainPageUrl = pulumi.interpolate`https://storage.googleapis.com/${bucket.name}/${mainPage.name}`
exports.notFoundPageUrl = pulumi.interpolate`https://storage.googleapis.com/${bucket.name}/${notFoundPage.name}`
