From: raven@themaw.net
Subject: RE: Another (stupid) question: autofs vs nfs for
	automounting purposes
Date: Mon, 14 Jun 2004 18:10:34 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406141803260.1394@donald.themaw.net>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AF@frodo.avalon.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3841AF@frodo.avalon.ru>
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
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: autofs@linux.kernel.org

On Mon, 14 Jun 2004, Dimitry V. Ketov wrote:

> > -----Original Message-----
> > From: raven@themaw.net [mailto:raven@themaw.net] 
> > 
> > On Fri, 11 Jun 2004, Dimitry V. Ketov wrote:
> > 
> > > - Which reasons (besides simplicity) led developers to the autofs 
> > > solution?
> > > - What's wrong with nfs for the same things?
> > 
> > I don't understand your question.
> > 
> > What has NFS to do with automounting?
> Sorry, if I'm unclear.
> I really meant communication protocol between kernel and the userspace
> for automounting purposes.
> As I know, early automounting solutions was (and current am-utils is)
> based on userspace nfs server daemon that mount itself on the autmomount
> points and then listen for filesystem traverses that trigger mounting.
> I understand that nfs was designed for different purposes, but anyway
> what reason to design new communication protocol and to complicate
> kernel instead using already in-kernel nfs code?

I'm not really familiar with amd so I can't comment on that.

Historically there are two ways to implement automount one being 
userspace, RPC based and the other being kernel based. autofs uses the 
kernel based method. It doesn't seem to me using the in kernel NFS would 
be sensible but someone would need to enlighten me on that.

In any case this implementation is a kernel based automounter. If you 
would like to use the other implementation then I believe amd is quite a 
capable product.

Ian
