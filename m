From: Ian Kent <raven@themaw.net>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Tue, 02 Oct 2007 12:36:03 +0800
Message-ID: <1191299763.26331.12.camel@raven.themaw.net>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191269783.12687.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191269783.12687.6.camel@localhost>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-10-01 at 22:16 +0200, Lukas Kolbe wrote:
> Hello List!
> 
> 
> > We have /homes coming from many different servers, the older ones only
> > speak v3 and the newer ones would love to speak v4 as we would.
> 
> We do have a solution for this problem now, it seems. A bit of testing
> worked fine at least: We just use different yp-maps for solaris and
> Linux, and the linux map contains the
> "-fstype=nfs4,proto=tcp,port=2049"-Option for the entries on servers
> that support it. It seems like a hack, but at least it works.

At least there's a workaround.

> 
> For this to work, we just have to absolutely make sure that every single
> linux machine on the network supports nfs4 ... and I have yet to see a
> single one that does this well ;)
> 

Hehe.

Ian
