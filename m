From: Frederic Tronel <autofs@tronel.org>
Subject: Exporting an autofs filesystem by NFS
Date: Wed, 25 Oct 2006 17:42:53 +0200
Message-ID: <200610251742.53940.autofs@tronel.org>
Reply-To: autofs@tronel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,

I'm facing the following problem. I'm a user of the autodir project 
(http://www.intraperson.com/autodir). This project allows the automatic 
creation of users homedirs. The first time a process enters its homedir 
(let's say under the directory /home), the autodir daemon (in the same way 
autofs daemon would be triggered) checks if the user is a legal one (using 
libnss, and a LDAP directory in my case). If the user is valid and the 
homedir does not exists it is created under another directory (let's 
say /realhome) and automatically mounts it under /home (mount --bind). It 
heavily relies on the autofs4 kernel module to realize this.

I would like to export the entire /home directory (which is in fact an autodir 
filesystem, i.e. its superblock is managed by autofs4) using NFS, as I would 
be able to do it, if /home was a regular filesystem.
This is unfortunately impossible since autofs4 is not an exportable 
filesystem. The reason is that in the autofs superblock the s_export_op field 
is left equal to NULL. I would like to know if there already exists a patch 
that makes autofs4 exportable somewhere around there ? If not, does it makes 
sense to develop such a patch (read  am I the only one who want to export a 
whole autofs filesystem ?).

Cheers,

Frederic  
