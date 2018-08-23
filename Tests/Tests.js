
var assert = require('assert')
var cmd = require('node-cmd')
var mocha = require('mocha')

var cmdroot = undefined
var result = undefined

describe('run', function() {

    this.result = undefined

    before(function(callback) {
        var self = this
        resetLocalizations(function() {
            getCmdroot(function(cmdroot) {
                getResult(cmdroot, function(result) {
                    self.result = result
                    callback()
                })
            })
        })
    })

    it('number of rows', function() {
        assert.equal(this.result.length, 14)
    })

    it('number of localizable files', function() {
        assert.equal(this.result.filter(function(row) {
            return row.indexOf('>') > -1
        }).length, 6)
    })

    it('en.lproj/Localizable1.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 1)
        assert.hasIssue(issues, "6", "warning", "exist", "unknown")
    })

    it('en.lproj/Localizable2.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 1)
        assert.hasIssue(issues, "2", "warning", "duplicate", "description")
    })

    it('en.lproj/Default.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 2)
        assert.hasIssue(issues, "2", "error", "define", "description")
        assert.hasIssue(issues, "4", "error", "define", "descriptionNumber2")
    })

    it('sv.lproj/Localizable1.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 1)
        assert.hasIssue(issues, "6", "warning", "exist", "unknown")
    })

    it('sv.lproj/Localizable2.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 1)
        assert.hasIssue(issues, "2", "warning", "duplicate", "description")
    })

    it('sv.lproj/Default.strings', function() {
        var issues = findIssuesInFile(this.result, this.test.title)
        assert.equal(issues.length, 2)
        assert.hasIssue(issues, "3", "error", "define", "descriptionNumber1")
        assert.hasIssue(issues, "4", "error", "define", "descriptionNumber2")
    })

})

// ASSERT

assert.hasIssue = function(issues, lineNumber, type, issue, key) {
    issues = issues.filter(function(row) { return row.indexOf(lineNumber) == 0 })
    assert(issues.length > 0)
    issues = issues.filter(function(row) { return row.indexOf(type) > 0 })
    assert(issues.length > 0)
    issues = issues.filter(function(row) { return row.indexOf(issue) > 0 })
    assert(issues.length > 0)
    issues = issues.filter(function(row) { return row.indexOf(key) > 0 })
    assert.equal(issues.length, 1)
}

// FIND

var findIssuesInFile = function(result, file) {
    return result.filter(function(row) {
        return row.indexOf(file) == 0
    }).map(function(row) {
        return row.replace(file + ":", '')
    })
}

var findIssuesOnLine = function(result, file, lineNumber) {
    return findIssuesInFile(result, file)
}

// CMD

var resetLocalizations = function(callback) {
    cmd.get('npm run reset', callback)
}

var getCmdroot = function(callback) {
    cmd.get('pwd', function(err, data, stderr) {
        var cmdroot = data.replace('\n', '')
        callback(cmdroot)
    })
}

var getResult = function(cmdroot, callback) {
    cmd.get('CMDROOT="' + cmdroot + '" ../run', function(err, data, stderr) {
        var regex = new RegExp(cmdroot + '/Tests/Localizations/', 'g')
        var result = data.replace(regex, '')
        result = result.split('\n').slice(0, -1)
        callback(result)
    })
}
