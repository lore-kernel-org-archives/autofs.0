From: Mike Marion <mmarion@qualcomm.com>
Subject: Program map and submount problem
Date: Fri, 23 Jan 2004 01:01:43 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C42E1561-4D82-11D8-92C5-000A95A011F0@qualcomm.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Wondering if anyone has seen this case with newer 4.1.0 daemon/module 
and direct map used via program (we have mounts in mounts in direct map 
so can't use built-in direct support).

mmarion @ linux-glab-1 54 [~]% zgrep submount /var/log/syslog.0.Z
Jan 22 23:43:10 linux-glab-1 automount[2171]: starting automounter 
version 4.1.0, path = /usr/local/projects/some/automount/submount, 
maptype = program, mapname = /etc/auto.projects.sh
Jan 22 23:43:27 linux-glab-1 automount[2229]: failed to mount 
/usr/local/projects/some/automount/submount/rpcinfo
Jan 22 23:49:21 linux-glab-1 automount[2171]: umount 
/usr/local/projects/some/automount/submount failed: retrying...
Jan 22 23:49:22 linux-glab-1 automount[2171]: umount 
/usr/local/projects/some/automount/submount failed: retrying...
Jan 22 23:49:23 linux-glab-1 automount[2171]: can't unmount 
/usr/local/projects/some/automount/submount
Jan 22 23:49:23 linux-glab-1 automount[2171]: shut down, path = 
/usr/local/projects/some/automount/submount
Jan 22 23:49:23 linux-glab-1 automount[2171]: failed to remove dir 
/usr/local/projects/some/automount/submount: Device or resource busy

The above happens when one cd's into 
/usr/local/projects/some/automount/submount, which is not yet an NFS 
mount point, and does an ls of a few directories under there, which are 
NFS mounts.  The mounts work fine.  However, leave the shell idle in 
submount, and after the NFS mounts time out and are umounted, autofs 
tries to unmount .../some/automount/submount, but fails with above 
message, but automount daemon on that point dies, and any mounts from 
that point on become inaccessible.

The only fix appears to be to shutdown all automount submounts back to 
the parent (in this case, /usr/local/projects) and then restart a new 
automount on /usr/local/projects.  Then the full path above can be seen 
again and mounts accessed from there.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
