From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Another (stupid) question: autofs vs nfs for
	automounting purposes
Date: Mon, 14 Jun 2004 15:28:09 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B384E3A15@frodo.avalon.ru>
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
To: autofs@linux.kernel.org

> -----Original Message-----
> From: raven@themaw.net [mailto:raven@themaw.net] 

> > communication protocol and to complicate kernel instead 
> using already 
> > in-kernel nfs code?
> 
> I'm not really familiar with amd so I can't comment on that.
> 
> Historically there are two ways to implement automount one being 
> userspace, RPC based and the other being kernel based. autofs 
> uses the 
> kernel based method. It doesn't seem to me using the in 
> kernel NFS would 
> be sensible but someone would need to enlighten me on that.
> 
> In any case this implementation is a kernel based automounter. If you 
> would like to use the other implementation then I believe amd 
> is quite a 
> capable product.
:) Nope. Just trying to figure out why two different implementations is
still exists.
Anyway thanks,


Dimitry.
