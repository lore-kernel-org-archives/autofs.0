From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: Re: Automount/NFS issues causing executables to appear 
 corrupted
Date: Tue, 20 Apr 2004 09:35:03 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40853517.71EB10A9@ssa.crane.navy.mil>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
To: Venkata Ravella <Venkata.Ravella@synopsys.com>
Cc: autofs@linux.kernel.org

question,
Is the file system mounted with the 'soft' option?
i.e. on the systems that are causing problems try
if mount | grep -i soft >>/dev/null 2>&1
then
  echo "we have soft mounts"
else
  echo "good, only normal mounts"
fi

We had a problem that caused me headaches for 6 months to track down... One of
the other admins had chosen to mount all the file systems with the soft option
and propagated this to all machines he could, that is to any I did not
control, and then people using his config started asking me why they were
getting IO errors transferring files to/from the file server I maintained.  if
the file was bigger than would fit in the normal [wr]size, which defaults to
1024 bytes {or 4096 dependent on which kernel version I believe} the
probability of an IO error during normal operations went from 0 towards
certainty by the time the file was 650 MBytes, generally would happen by
~100MBytes.

My server was a sun ultra 2 running solaris 2.6, the clients were Linux
running 2.[02].X and a mix of autofs-3 and autofs-4 (which ever was installed
with the distros, RH6-9 & Slack7-9.1).

I have a script being ran in everyone's .profile now to help me find any
remaining soft holdouts because it caused so much trouble.
The alternative to 'soft' for us was 'hard,intr' which at least allows you to
break the applications when you really need to, but be much more robust in
normal operations.


Venkata Ravella wrote:
> 
> autofs version is .1.7-21
> 
> I also have one new update. We started seeing similar problem on
> the system running the kernel 2.4.18-e.12smp which has the same
> version(3.1.7-21) of autofs as well.
> 
> This may or may not be an autofs problem but, restarting autofs
> fixes this problem temporarily.
> 
> >
> >Please cc autofs questions to the list at autofs@linux.kernel.org.
> >
> >On Sun, 18 Apr 2004, Venkata Ravella wrote:
> >
> >>
> >> The current kernel we use is default 7.2 kernel with two modifications:
> >> 1) BM patch applied to extend address space for a single process to 3.6GB
> >> 2) mnt patch applied to allow upto 1024 nfs mount points
> >>
> >> uname -r output:
> >> 2.4.7-10mntBMsmp
> >
> >What autofs version?
> >
> >To be honest it's a bit hard to see how this is an autofs issue.
> >Mind, having said that, ....
> >
> >Ian

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane) 
Harnessing the Power of Technology for the Warfighter
