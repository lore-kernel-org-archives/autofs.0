From: Al Alder <aalder@ti.com>
Subject: Re: multiple hostnames in automounter table
Date: Mon, 28 Jun 2004 06:45:41 -0500 (CDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0406280641090.13838-100000@shiloh.dal.design.ti.com>
References: <Pine.LNX.4.58.0406252248010.1375@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406252248010.1375@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Ian,

Thank you for your reply.  You guys do great work. 

-- 
Later,
Al
-----------------------------------------------------
Al Alder      | TI Email: aalder@ti.com
Texas Instruments | phone: (214) 480-3996 

On Fri, 25 Jun 2004 raven@themaw.net wrote:

> On Thu, 24 Jun 2004, Jeff Moyer wrote:
> 
> > ==> Regarding [autofs] multiple hostnames in automounter table; Al Alder <aalder@ti.com> adds:
> > 
> > aalder> Are there any plans for the automounter to be able to handle
> > aalder> multiple hostnames in the automount table for Linux?  With Mandrake
> > aalder> 10.0 the automount daemon will not mount an entry that has multiple
> > aalder> hostnames.  On Red Hat Enterprise 3.0, it gives a warning, but will
> > aalder> mount using the first hostname, is this functionality a RedHat
> > aalder> thing that hasn't been shared with the rest of the community or is
> > aalder> Mandrake 10.0 just using a different/older version?  Is there
> > aalder> anyway around this problem, or to get Mandrake automount to mount
> > aalder> the first hostname?
> > 
> > aalder> Your help is appreciated.
> > 
> > RHEL 3 uses a heavily patched autofs-3.1.7.  Most of the changes made by
> > Red Hat have been incorporated in autofs-4.x.y by Ian.  I try to involve
> > Ian and the list in all of the changes I make to the automounter.  The only
> > times I don't are when I get rediculous user requests that I am obligated
> > to fulfill.
> > 
> > Having said that, I'm guessing what you want is replicated server
> > functionality?  I would suggest starting with the README.replicated-server
> > file in the autofs 4 userspace package.  Hopefully it does what you need it
> > to do.
> 
> Yes. As Jeff says.
> 
> But there has been quite a bit of work done relating to side effects 
> from the initial implementation of the replicated functionality by myself 
> and Jeff. So this functionality is still stabilising. Hopefully the next 
> release will see that work complete.
> 
> Ian
> 
> 
