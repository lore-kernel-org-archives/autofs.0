From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: Re: Automount/NFS issues causing executables to 
 appearcorrupted
Date: Wed, 21 Apr 2004 09:03:33 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40867F35.7F41AC64@ssa.crane.navy.mil>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
	<Pine.LNX.4.53.0404201803380.3764@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

Jim Carter wrote:
> 
> Sorry to continue a non-automount issue, but this is where it was posted...
This is the only NFS related list I am subscribed to.

> 
> On Tue, 20 Apr 2004, Todd Denniston wrote:
> 
> > question,
> > Is the file system mounted with the 'soft' option?
> > i.e. on the systems that are causing problems try
> > mount | grep -i soft
> 
> > We had a problem that caused me headaches for 6 months to track down...
> 
> > ...probability of an IO error during normal operations went from 0 towards
> > certainty by the time the file was 650 MBytes, generally would happen by
> > ~100MBytes.
> >
> > My server was a sun ultra 2 running solaris 2.6, the clients were Linux
> > running 2.[02].X and a mix of autofs-3 and autofs-4 (which ever was installed
> > with the distros, RH6-9 & Slack7-9.1).
> 
> We have Solaris 2.6, Solaris 8 (not tested), SuSE 8.2 (kernel 2.4.20) and
> SuSE 9.0 (kernel 2.4.21, not tested).  I just ran some tests as follows:
> Write one file of 1.3 Gb into the partner's NFS-exported filesystem.  Read
> it back comparing bit-for-bit.  Delete the NFS file.  This was tried twice
> with a Solaris 2.6 partner and twice with a Linux (2.4.20) partner.  The
> local machine has Linux (2.4.20).  Both partners were on a different
> subnet, but traffic was light and dropped UDP packets probably were very
> few.  
There are at least two differences
1) you have light network traffic, at times we have a couple of video streams
going across our 100Mb net, and 50 users that have a bad habit of keeping
there netscape caches on the network drives.
2) our server has a veritas controlled 64 disk software raid set which seems
to eat kernel time, nfs seems to use a lot of kernel time too, so probably
more dropped UDP packets.
3) solaris nfs server -> linux clients.... I have heard that in olden days the
nfs servers and clients of different OSs handled things differently from one
another and this caused some lossage, which is probably more apparent in error
conditions like dropped UDP packets.
4) Oh, and all these disks were on fibre channel from back when dot hill was
box hill (97-98 time frame), further investigation showed (when I did it a
long time ago) that when linux was using fibre cards that reported the same
make+model+version as ours they had to do several things to keep the cards
running right ... seems they did not quite work right, and we never got
updated drivers from box hill before our support contracts ran out (which was
before I took over the machine).

> All NFS mounts were courtesy of the automounter.  All were soft,
> specifically: -rsize=8192,wsize=8192,retry=1,soft.
> 
> There were no errors whatsoever.  Execution times were identical on
> repeat trials (meaning no erratic network timeouts).  At Mathnet,
> historically we do not see any of the described symptoms.

for me copy times would change on the order of 5 to 10 minutes for a 650MB
file.

> 
> I wonder what's going on at your end.  If it's going to jump up and bite us
> in the future...
> 
As our user load increased from 25 to 50, so did the frequency of IO errors.

from the linux `man nfs`
       soft           If an NFS file operation has a major timeout then report
                      an I/O error to the calling program.  The default is  to
                      continue retrying NFS file operations indefinitely.

       hard           If an NFS file operation has a major timeout then report
                      "server not responding"  on  the  console  and  continue
                      retrying indefinitely.  This is the default.

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane) 
Harnessing the Power of Technology for the Warfighter
