From: chris barry <Christopher.Barry@qlogic.com>
Subject: Re: bind mounting into a generated multi-level
	directory	structure
Date: Thu, 14 Feb 2008 17:32:52 -0500
Message-ID: <1203028372.8007.54.camel@localhost>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>
	<47AF07BF.2040405@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47AF07BF.2040405@bononline.nl>
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
Cc: autofs@linux.kernel.org

On Sun, 2008-02-10 at 15:18 +0100, Stef Bon wrote:
> Chris Stromsoe wrote:
> > I have a set of directories that are created and removed programmatically, 
> > and are hashed three levels deep (/top/hash/hash/name).  The depth is 
> > constant, the hashes and names are not.  There are around 35k at any time. 
> > I would like to bind mount a common directory into each top-level 
> > (/top/hash/hash/name/data) on demand.
> >
> > Can I use autofs to do that without having to explicitly list all of the 
> > directory paths in auto.master?
> >   
> Why not use symlinks to this shared common directory, and mount that one?
> 
> Stef Bon

His goal is to create a chroot'd environment, and the symlink cannot
function there. man chroot to help you understand why.

-C
