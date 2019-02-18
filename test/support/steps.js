const { When, Then } = require("cucumber")
const assert = require("assert")

const request = require("supertest");
const app = require(process.cwd() + "/server/app").app;

When('I GET the endpoint {string}', function (path) {
  this.request = request(app).get(path);
});

Then('I should get a {int} with body', function (status, body, done) {
  this.request.expect(status).expect(body).end(done);
});

Then('I should get the message', function (message) {
  if (this.response + "" !== message) {
    console.log("EXPECTED", message)
    console.log("ACTUAL", this.response + "")
  }
  assert(this.response + "" == message);
});