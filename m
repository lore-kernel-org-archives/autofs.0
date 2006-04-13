From: Mike Marion <mmarion@qualcomm.com>
Subject: Mounts not happening for "remote" processes
Date: Wed, 12 Apr 2006 18:36:29 -0700
Message-ID: <20060413013629.GH19971@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

One of the last problems we're having with autofs4 is the fact that we
see a lot of cases where a "remote" job can't see files in nfs.  By
"remote" I mean jobs like those dispatched by our LSF system, where
processes are started on hosts without a user actually logging in.  The
programs they run will stat a file looking for it's input, or binary, or
whatever, then it's like the mount doesn't happen, or isn't atomic
enough, and the program will fail.  If we immediately log into the host
and do something like ls the same file.. it works fine.

I've been able to reproduce this behavior (sometimes) using apache on a
host and requesting a file symlinked out of an NFS path, but it's hard
to get it to happen when I want.  I've turned on --debug and --verbose
on some hosts for more info.  BTW, I've noticed that if you add --debug
and --verbose in the init script as daemonoptions, and use a /- direct
map entry, it only has the children inherit --debug but not --verbose.

Anyway.. I was able to get some data where a path mounted fine
( /prj/qct/gv in this case while apache tried to stat
/prj/qct/gv/x86_64/sles10-b9/GV/profiles/default/classes/software/sles10.xml),
but on a reload after the path expired, it failed... 

Logs show:
Apr 12 18:12:21 rs-workstation automount[8493]: expired /prj/qct/gv
mode
Apr 12 18:13:28 rs-workstation automount[8253]: attempting to mount
entry /prj/qct/gv
Apr 12 18:13:49 rs-workstation automount[8517]: mount(nfs): nfs: mount
failure ronald:/ vol/eng_ice_0014/qct_gv on /prj/qct/gv
Apr 12 18:13:49 rs-workstation automount[8517]: failed to mount
/prj/qct/gv
Apr 12 18:13:49 rs-workstation automount[8532]: failed to mount
/prj/qct/gv/x86_64
Apr 12 18:13:49 rs-workstation automount[8517]: >> mount: RPC: Timed out
Apr 12 18:13:49 rs-workstation automount[8517]: mount(nfs): nfs: mount
failure ronald:/ vol/eng_ice_0014/qct_gv on /prj/qct/gv
Apr 12 18:13:49 rs-workstation automount[8517]: failed to mount
/prj/qct/gv
Apr 12 18:13:49 rs-workstation automount[8517]: umount_multi: no mounts
found under /pr j/qct/gv
Apr 12 18:13:49 rs-workstation automount[8253]: attempting to mount
entry /prj/qct/gv/x 86_64
Apr 12 18:13:49 rs-workstation automount[8532]: failed to mount
/prj/qct/gv/x86_64
Apr 12 18:13:49 rs-workstation automount[8532]: umount_multi: no mounts
found under /pr j/qct/gv/x86_64
Apr 12 18:13:49 rs-workstation automount[8253]: attempting to mount
entry /prj/qct/gv
Apr 12 18:14:10 rs-workstation automount[8535]: mount(nfs): nfs: mount
failure ronald:/ vol/eng_ice_0014/qct_gv on /prj/qct/gv
Apr 12 18:14:10 rs-workstation automount[8535]: failed to mount
/prj/qct/gv
Apr 12 18:14:10 rs-workstation automount[8535]: >> mount: RPC: Timed out
Apr 12 18:14:10 rs-workstation automount[8535]: mount(nfs): nfs: mount
failure ronald:/ vol/eng_ice_0014/qct_gv on /prj/qct/gv
Apr 12 18:14:10 rs-workstation automount[8535]: failed to mount
/prj/qct/gv
Apr 12 18:14:10 rs-workstation automount[8535]: umount_multi: no mounts
found under /pr j/qct/gv
Apr 12 18:14:12 rs-workstation automount[6339]: attempting to mount
entry /usr2/mmarion

I was able to snag an ethereal of the conversation between the host and
the NFS server (here to save size: http://www.miguelito.org/autofs.cap).

I got a strace of the mount call that had that issue too.

I don't know if this is always what happens when the mounts fail on LSF
jobs since we haven't been running with debug or verbose for long.

I'm currently running autofs-4.1.4 with the following patches:
autofs-4.1.4-multi-parse-fix.patch
autofs-4.1.4-non-replicated-ping.patch
autofs-4.1.4-misc-fixes.patch

and the suse-9.2 kernel 
2.6.5-7.147-smp which appeared to have all the autofs4 kernel patches up
to at least the time of the above daemon patches.

Also, I've noticed patches mentioning autofs5 on the list, but must've
missed how we can test this if we want.. or I'm nuts and way off. :)
-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Ned: "We must've really painted the town last night.  I have a pounding 
headache, my mouth tastes like vomit, and I don't remember a thing!"
Homer: "Welcome to my world."  ==> Simpsons
