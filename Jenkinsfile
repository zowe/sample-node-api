#!groovy

/**
 * This program and the accompanying materials are made available under the terms of the
 * Eclipse Public License v2.0 which accompanies this distribution, and is available at
 * https://www.eclipse.org/legal/epl-v20.html
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Copyright IBM Corporation 2020
 */


node('ibm-jenkins-slave-dind') {
  def lib = library("jenkins-library").org.zowe.jenkins_shared_library

  def pipeline = lib.pipelines.nodejs.NodeJSPipeline.new(this)

  pipeline.admins.add("stevenh")

  pipeline.setup(
    packageName: 'org.zowe.sample-node-api',
    nodeJsVersion: 'v10.18.1',
    github: [
      email                      : lib.Constants.DEFAULT_GITHUB_ROBOT_EMAIL,
      usernamePasswordCredential : lib.Constants.DEFAULT_GITHUB_ROBOT_CREDENTIAL,
    ],
    artifactory: [
      url                        : lib.Constants.DEFAULT_LFJ_ARTIFACTORY_URL,
      usernamePasswordCredential : lib.Constants.DEFAULT_LFJ_ARTIFACTORY_ROBOT_CREDENTIAL,
    ],
    pax: [
      sshHost                    : lib.Constants.DEFAULT_PAX_PACKAGING_SSH_HOST,
      sshPort                    : lib.Constants.DEFAULT_PAX_PACKAGING_SSH_PORT,
      sshCredential              : lib.Constants.DEFAULT_PAX_PACKAGING_SSH_CREDENTIAL,
      remoteWorkspace            : lib.Constants.DEFAULT_PAX_PACKAGING_REMOTE_WORKSPACE,
    ],
    installRegistries: [
      [
        email                      : lib.Constants.DEFAULT_LFJ_NPM_PRIVATE_REGISTRY_EMAIL,
        usernamePasswordCredential : lib.Constants.DEFAULT_LFJ_NPM_PRIVATE_REGISTRY_CREDENTIAL,
        registry                   : lib.Constants.DEFAULT_LFJ_NPM_PRIVATE_REGISTRY_INSTALL,
      ]
    ],
    publishRegistry: [
      email                      : lib.Constants.DEFAULT_LFJ_NPM_PRIVATE_REGISTRY_EMAIL,
      usernamePasswordCredential : lib.Constants.DEFAULT_LFJ_NPM_PRIVATE_REGISTRY_CREDENTIAL,
    ],
    // FIXME: ideally this should set to false (using default by remove this line)
    ignoreAuditFailure            : true,
    // FIXME: npm version in ibm-jenkins-slave-dind is too old, doesn't support "npm ci"
    alwaysUseNpmInstall           : true

  )

  pipeline.build()

  // // we have a custom build command
  // pipeline.build(
  //   operation: {
  //     ansiColor('xterm') {
  //       pipeline.nvmShell "npm run prod"
  //     }
  //   }
  // )

  // pipeline.test(
  //   name          : 'Unit',
  //   junit         : "target/report.xml",
  //   cobertura     : [
  //     coberturaReportFile       : "coverage/cobertura-coverage.xml",
  //     // if coverage check failed, the pipeline will be marked as UNSTABLE, which
  //     // will block publish/release. So we overwrite default and set to false here.
  //     // FIXME: ideally this should set to true (using default by remove this line)
  //     autoUpdateStability       : false,
  //     fileCoverageTargets       : '100, 0, 0',
  //     classCoverageTargets      : '85, 0, 0',
  //     methodCoverageTargets     : '80, 0, 0',
  //     lineCoverageTargets       : '80, 0, 0',
  //     conditionalCoverageTargets: '70, 0, 0',
  //   ],
  //   htmlReports   : [
  //     [dir: "coverage/lcov-report", files: "index.html", name: "Report: Code Coverage"],
  //   ],
  // )

  // we need sonar scan
  // failBuild set to false whilst investigating https://github.com/zowe/zlux/issues/285
  pipeline.sonarScan(
    scannerTool     : lib.Constants.DEFAULT_LFJ_SONARCLOUD_SCANNER_TOOL,
    scannerServer   : lib.Constants.DEFAULT_LFJ_SONARCLOUD_SERVER,
    allowBranchScan : lib.Constants.DEFAULT_LFJ_SONARCLOUD_ALLOW_BRANCH,
    failBuild       : false
  )

  // we have pax packaging step
  pipeline.packaging(name: 'sample-node-api')

  // define we need publish stage
  pipeline.publish(
    operation: {
      echo "Default npm publish will be skipped."
    },
    artifacts: [
      '.pax/sample-node-api.pax'
    ],
    allowPublishWithoutTest: true // There are no tests
  )

  // define we need release stage
  // pipeline.release()

  pipeline.end()
}
