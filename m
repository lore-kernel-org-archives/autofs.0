From: David <spoel@xray.bmc.uu.se>
Subject: Re: autofs not mounting from nis maps
Date: Thu, 17 Mar 2005 09:29:33 +0100
Message-ID: <1111048173.5590.38.camel@studio.bibu>
References: <1111004718.6120.16.camel@studio.bibu>
	<Pine.LNX.4.61.0503161515040.7630@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0503161515040.7630@xena.cft.ca.us>
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
Content-Type: text/plain; charset="us-ascii"
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Wed, 2005-03-16 at 15:31 -0800, Jim Carter wrote:
> On Wed, 16 Mar 2005, David wrote:
> > [root@appel2 proc]# ypcat -k auto.master
> > /home  auto.home
> --- snip ---
> > [root@appel2 proc]# ypcat -k auto.home | head -8
> > magnusa  hirst:/homes/hirst/dsk1/&
> 
> We do almost exactly the same thing, except our auto.home map includes the
> full path name, i.e.
> 	prob-mp sonia:/h1/guest/prob-mp
> rather than using the &.  But I'm sure this is not your problem.  I 
> explicitly specify the map type in /etc/auto.master, i.e. 
> 	/home           yp:auto.home
> but again, I doubt that has anything to do with your problem.

OK, found it. 
There were spaces instead of tabs between key and value. Apparently NIS
chokes on that.

Now it works.



-- 
David.
________________________________________________________________________
David van der Spoel, PhD, Assoc. Prof., Molecular Biophysics group,
Dept. of Cell and Molecular Biology, Uppsala University.
Husargatan 3, Box 596,          75124 Uppsala, Sweden
phone:  46 18 471 4205          fax: 46 18 511 755
spoel@xray.bmc.uu.se    spoel@gromacs.org   http://xray.bmc.uu.se/~spoel
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
