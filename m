From: mmarion@qualcomm.com
Subject: Failure to find path that exists..
Date: Wed, 17 Nov 2004 11:12:13 -0800 (PST)
Message-ID: <200411171912.iAHJCDkY017634@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Running into a new problem lately, or at least more-so lately.  We use a
program map (shell script) to support our sun direct mount maps here.  It's
been working mostly as expected, but this new problem has cropped up, where a
user's job that is sent to a linux box via LSF, will fail to run due to it's
path failing to mount.

I found that watching the logs showed an entry like:
automount[32477]: lookup(program): lookup for lib failed 
in the syslogs (path was /iceng/lib so daemon on /iceng failed to find lib).

I turned on a bunch of verbose logging in the shell script to see if it was a
glitch there, but when the problem re-occured, there was no corroborating data
at all.  So it seems the daemon didn't even exec the shell script.  I was able
to turn on --debug on the automount daemon on a few hosts (this is happening
on our itanium hosts more then anywhere else right now, I think because of the
program running there and the less-used paths, I don't think the arch has any
effect).  The logs today show:
Nov 17 08:03:16 compute-ia64-san-005 automount[32470]: expired /iceng/lib/ram 
Nov 17 08:03:16 compute-ia64-san-005 automount[32081]: shut down, path =
/iceng/lib 
Nov 17 08:03:16 compute-ia64-san-005 automount[32477]: lookup(program): lookup
for lib failed 
Nov 17 08:03:16 compute-ia64-san-005 automount[32477]: failed to recover from
partial expiry of /iceng/lib  

It looks to me like this might be a race condition where the path is being
expired at almost the exact time that a new request for the path comes in.  

I'm running autofs-4.1.2 on these hosts right now, but have upgraded to 4.1.3
with the bad_chdir, mtab_lock, non_block_ping and strict patches on one of
thes hosts.. and haven't seen the problem there again yet (but I also don't
know if the users have gotten new jobs on there since last night).

Has anyone seem similar issues, or know if one of the above patches for 4.1.3
might fix this?  I'm going ahead with upgrading to the same on all the hosts I
can anyway, but it's hard to get patches onto the ia64's (high demand for them
all the time) without solid proof that it'll help.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"Because right now, developing software for Microsoft is like brushing the
teeth of a Great White Shark with a piece of raw steak." - Robert G. Brown,
Linux Today; Nov 13th, 1998
