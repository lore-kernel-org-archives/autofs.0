From: mmarion@qualcomm.com
Subject: /net with program map problem on x86_64
Date: Fri, 5 Mar 2004 18:04:23 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403060204.i2624NgQ000399@miguelito.qualcomm.com>
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Here's a new one I've run into.  Finally got a full auto-yast install setup
for Suse SLES8 on a dual opteron system that incorporates all our company
configurations automatically as well.

I'm running the beta 4.1.1 code (don't know if it's released to wide audience
yet) and it's been running perfectly fine on x86 hosts for a month or more.

We have massive direct maps that were originally for an all sun environment
that we use program maps to parse/mount with.  The direct maps are working
fine, as are the homedir mounts (auto.home yp map)... but my /net program
mapped mount is broken now.  The program file still returns exactly what I'd
expect, but for some reason, the automount daemon can't create the necessary
directories in the /net tree?!?  Not sure what would cause this or where it
would be tripped.

syslog shows:
Mar  5 17:48:21 rs-blade automount[4277]: mount(nfs): mkdir_path  failed:
Operation not permitted

and a strace of the daemon shows:
[pid  4932] mkdir("/net", 0555)         = -1 EEXIST (File exists)
[pid  4932] stat("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
[pid  4932] mkdir("/net/mig", 0555)     = 0
[pid  4932] mkdir("/net/mig/local", 0555) = -1 EPERM (Operation not permitted)

it then does it again later:
[pid  4998] mkdir("/net", 0555)         = -1 EEXIST (File exists)
[pid  4998] stat("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
[pid  4998] mkdir("/net/mig", 0555)     = 0
[pid  4998] mkdir("/net/mig/local", 0555) = -1 EPERM (Operation not permitted)


The problem is probably related to:
PANIC: attached pid 4942 exited
PANIC: attached pid 4945 exited
PANIC: attached pid 4948 exited
PANIC: attached pid 4953 exited
PANIC: attached pid 4936 exited
PANIC: attached pid 5009 exited
PANIC: attached pid 5012 exited
PANIC: attached pid 5015 exited
PANIC: attached pid 5020 exited
PANIC: attached pid 5003 exited
but none of those pids show any indication of what was running.. they appear
to be processes waiting for the call to the program /etc/auto.net to finish.
But from what I can see (especially since the mkdir is following the path down
/net as though it knows what/where to mount) the correct results are getting
to the daemon bits.

Anyway.. very confusing.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
[Homer left a 'Dear Jane' tape for Marge]
Homer: "Marge, if you're watching this then it means I figured out how to work
the camera."  ==> Simpsons
