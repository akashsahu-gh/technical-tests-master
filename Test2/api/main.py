import flask
from flask import request, jsonify
import git
import subprocess

app = flask.Flask(__name__)
#app.config["DEBUG"] = True

#Get last sha commit from gitub repo
sha=subprocess.check_output(['git', 'rev-parse', 'HEAD']).replace('\n','')

#Get application version from git commits
repo_path = './'
repo = git.Repo(repo_path)
version = repo.git.rev_list('--count', 'HEAD')

result={ "myApplication" : [ 
    {   'version': version, 
        "lastcommitsha": sha, 
        "Description:": "Pre-interview technical test" 
    }] 
    }

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Test Program for ANZx</h1>
<p>Tests program to get version and sha for Application from GitHub Repo</p>'''

# A route to return all of the available entries in our catalog.
@app.route('/api/version', methods=['GET'])
def api_all():
    return jsonify(result)


if __name__ == '__main__':
      app.run(host='0.0.0.0', port=8080)