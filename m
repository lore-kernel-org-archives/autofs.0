From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: RE: [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 17:53:34 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401061746470.16793-100000@gate.nmr.mgh.harvard.edu>
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, thockin@Sun.COM, Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

As another sysadmin with 300+ linux and solaris boxes, I second
you sentiments exactly.  As my previous post today states, I am
having exactly the problem you describe with automount daemons
becoming hung or unresponsive.  Guess I should give 4.1.0 a try.  

Of course the same arguement applies to NFS server but they went
ahead and moved most of that into the kernel anyway for the 
performance gain.

-- 
---------------------------------------------------------------
Paul Raines                   email: raines@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street        Charlestown, MA 02129	USA   
