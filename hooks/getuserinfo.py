#coding: gb2312
import sys
import os
from datetime import *

def get_repo_name(repo):
        return os.path.basename(repo)

def get_author(repo, rev):
        """svnlook author -r REV REPOS 获得提交者
        """
        cmd = '%s author -r %s %s' % (svnlook_bin_path, rev, repo)
        output = os.popen(cmd).read().strip('\n')
        return output

def get_date(repo, rev):
        """svnlook date -r REV REPOS 获得提交时间
        """
        cmd = '%s date -r %s %s' % (svnlook_bin_path, rev, repo)
        output = os.popen(cmd).read()
        return output

def get_log(repo, rev):
        """svnlook log -r REV REPOS 获得提交日志
        """
        cmd = '%s log -r %s %s' % (svnlook_bin_path, rev, repo)
        output = os.popen(cmd).read().strip('\n')
        return output

def get_file_list(repo, rev):
        """svnlook changed -r REV REPOS 获得发生变更的文件
        """
        cmd = '%s changed -r %s %s' % (svnlook_bin_path, rev, repo)
        output = os.popen(cmd).read()
        return output

global svnlook_bin_path
if __name__ == '__main__':
        today = str(date.today())
        svnlook_bin_path = sys.argv[1]
        repo_in = sys.argv[2]
        reve_in = sys.argv[3]
        info_log= sys.argv[4]
        author = get_author(repo_in,reve_in)
        info = get_log(repo_in,reve_in)
        msg = '%s:%s,\n'%(author,info)
        output=open(info_log,'a')
        output.write(msg)
        output.close()
        
