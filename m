From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 17:34:08 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6BE7@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: Tim Hockin <thockin@hockin.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, thockin@Sun.COM, Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>



> -----Original Message-----
> From: Tim Hockin [mailto:thockin@hockin.org] 
> Sent: Tuesday, January 06, 2004 4:48 PM
> To: Ogden, Aaron A.
> Cc: thockin@Sun.COM; H. Peter Anvin; autofs mailing list; 
> Mike Waychison; Kernel Mailing List
> Subject: Re: [autofs] [RFC] Towards a Modern Autofs
> 
> 
> On Tue, Jan 06, 2004 at 04:28:59PM -0600, Ogden, Aaron A. wrote:
> > Solaris there is a command called 'automount' that tells the kernel
to
> > re-read the automount maps, perhaps it resets the autofs subsystem
in
> > the kernel as well.  If linux autofs had the same capability we
might
> > not need the daemon, but until then, having the daemon in userland
is a
> > good thing.
> 
> That's more or less exactly what is proposed.
> 

Excellent!  I haven't read through the proposal yet but I have it open
in another window.  :-)
The detailed proposal you've written implies that Sun as a whole has
given serious thought to the problem, which IMHO is how to make linux
autofs work like Solaris autofs.  Is Sun willing to devote man-hours to
help implement the new autofs?  I think Ian has done a tremendous job
with autofs4 but the more minds we throw at the problem the better.
