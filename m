From: mmarion@qualcomm.com
Subject: Re: Program map and submount problem
Date: Fri, 23 Jan 2004 12:38:09 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401232038.i0NKc9pK019108@miguelito.qualcomm.com>
References: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On 23 Jan, Ian Kent wrote:

Hmm... for some reason I got 28 copies of this msg.. odd.

> On Fri, 23 Jan 2004, Mike Marion wrote:

>> Jan 22 23:49:23 linux-glab-1 automount[2171]: shut down, path = 
>> /usr/local/projects/some/automount/submount
>> Jan 22 23:49:23 linux-glab-1 automount[2171]: failed to remove dir 
>> /usr/local/projects/some/automount/submount: Device or resource busy
> 
> What does auto.projects.sh issue when executed in this context.

Not sure what you mean.  Do you mean what options did it startup the submount
with when it mounted to the /usr/local/projects/some/automount/submount point?
If so:
/usr/sbin/automount --submount /usr/local/projects/some/automount/submount program /etc/auto.projects.sh 60 -Dpref=

The -Dpref= option is a leftover from the original autofsv3 script, I
believe.  I'm trying a test without that to see if it makes any
difference but I doubt it.  Also going to strace the daemon on the
submount point to see what it does before quitting.

> What mounts work fine. 

I meant that before the problem occurs, I can do something like:
$ cd /usr/local/projects/some/automount/submount
$ ls -l bin lib
and see the contents of bin and lib, which are NFS mountpoints off of that
path.  After those points (bin and lib) expire, automount tries to expire the
submount point, and that's when the problem occurs.  The problem appears to be 
the automount daemon for /usr/local/projects/some/automount/submount will exit,
even though the path is still busy.  This causes the umount of the path
(.../some/automount/submount) to fail, which then makes that path (and any NFS 
mounts below it) inaccessible.

The log messages make it appear that the automount daemon on
/usr/local/projects/some/automount/submount is trying to umount itself without
bothering to see if it's a busy path or not.  It seems to assume that since
there are no submounts (either autofs or NFS) below it, that it's not busy.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
