From: "Francesco P. Lovergine" <frankie@debian.org>
Subject: Re: automount doesn't reread file map, automount terminates
	on empty file map
Date: Thu, 16 Dec 2004 15:56:20 +0100
Message-ID: <20041216145620.GD24795@ba.issia.cnr.it>
References: <1102796222l.6265l.2l@mercury>
	<Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au>
	<1103144614l.6934l.0l@mercury>
	<Pine.LNX.4.58.0412161052250.20186@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412161052250.20186@wombat.indigo.net.au>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, Dec 16, 2004 at 11:00:33AM +0800, Ian Kent wrote:
> > 
> > sorry I forgot to mention some essential information it seems, I use  
> > the 4.1.3-6 debian package.
> 
> I can't remember the patches that Arthur included in the deb (Arthur?).
> I'll check if we can't raise him.
>

Package is currently in adoption, Arthur missed time to continue with
proper maintainance.  Recently, me and Steinar Gunderson worked to
have the package in decent shape for sarge.

> A further difficulty with this is that to fix this problem a small kernel 
> patch was needed. But what kernel are you using (ie. are the latest kernel 
> updates included in it)?
> 

That's an interesting hint. I suspect our kernel team could be not aware 
of it. Do you have a pointer to the patch somewhere?

-- 
Francesco P. Lovergine
