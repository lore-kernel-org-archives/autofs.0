From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 17:26:11 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6BE6@slexch2.sugarland.unocal.com>
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
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>


> -----Original Message-----
> From: Paul Raines [mailto:raines@nmr.mgh.harvard.edu] 
> Sent: Tuesday, January 06, 2004 4:54 PM
> To: Ogden, Aaron A.
> Cc: thockin@Sun.COM; H. Peter Anvin; autofs mailing list; 
> Mike Waychison; Kernel Mailing List
> Subject: RE: [autofs] [RFC] Towards a Modern Autofs
> 
> 
> As another sysadmin with 300+ linux and solaris boxes, I second
> you sentiments exactly.  As my previous post today states, I am
> having exactly the problem you describe with automount daemons
> becoming hung or unresponsive.  Guess I should give 4.1.0 a try.  
> 
> Of course the same arguement applies to NFS server but they went
> ahead and moved most of that into the kernel anyway for the 
> performance gain.
> 

I have been working with Ian for a long time, the improvements he's made
since autofs-4.0.0pre10 have been tremendous.  Although the people from
Sun may not agree I think autofs 4.1.0 is mostly on par with Sun's
autofs, at least from a sysadmin perspective.  The code is still very
new but I have not been able to break it yet... unlike previous
versions.  :-)  

If you are going to use autofs on linux I would highly recommend the
latest version of autofs4, in my experience nothing else will cut it if
you want your linux autofs to behave like what you are used to in
Solaris.  This includes the browsing/ghosting feature.  Go to
ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/ and get the latest
tarball or source rpm.  You can install the daemon with that but you
also need to apply patches to the kernel module to get things working
properly, the patches are included in the file you download.

Good luck!
