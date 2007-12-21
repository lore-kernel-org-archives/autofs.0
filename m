From: Mike Marion <mmarion@qualcomm.com>
Subject: Seeing autofs-5.0.2 core dumping
Date: Thu, 20 Dec 2007 18:30:25 -0800
Message-ID: <20071221023024.GB10904@cornholio.qualcomm.com>
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

In the last 2 days we're seeing our autofs 5.0.2 daemon dumping core,
and it seems to be triggerd by a kill -HUP call to it to make it re-read
the maps.  Using all LDAP maps (and if HUP isn't needed there, we can
turn it off) and it only seems to trigger if the daemon has been running
for a least a few hours, as I can send it numerous HUP signals after
restarting it and it won't crash.

It looks like the HUP is making it try to shut down a subset of the
paths (and I see this in syslog sometimes without segfaulting too)..
where it does several entries of:

 automount[2475]: umounted direct mount <path>
followed by the same paths in the same order:
 automount[2475]: rmdir_path: lstat of <path> failed
and then it core dumps:
automount[7419]: segfault at 00002aaaac141e08 rip 0000000000410d63 rsp
0000000040627030 error 4

Sometimes that happens after 1 of the above failed rmdir_path lines,
sometimes after most or all.

gdb shows them all crashing at the same point:
#0  lookup_prune_cache (ap=0x54ace0, age=1198202622) at lookup.c:1014

Unfortunately I don't have the exact same patched copy of lookup.c, or
at least it didn't line up to a line with anything in it (was blank)
when I ran the build again and then used the file after rpm patched it.

This has only cropped up in the last few days.. 

Running SLES9-SP3 hosts with 2.6.16.21-0.8 kernel from sles10 built on
it (using src.rpm) with autofs5 patch added.  Autofs-5.0.2 with patches 
as of June of this year (I believe).

First possible thing that comes to mind:
- Are our maps just too big now?  We have huge maps now, a typical
  /proc/mounts has values like so:
$ grep ^auto. /proc/mounts  |wc
   6940   41640  815531

Yes.. we have almost 7000 mounts in the maps.  Those are all direct
mounts.  We have > 25,000 mounts in our homedir map, but that's an
indirect map.

If one of the newer patches in the last few months might address this,
I'll be happy to patch up.  

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Groundskeeper Willie: "What? Have you gone waxie in your pister? I canna' fit
in the wee vent, you croquet playing mint muncher."
Principal Skinner: "Greese yourself up and go in you... you, guff speaking work
slacker!"
Willie: "Oooh.  Good comeback."  ==> Simpsons.
