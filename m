From: Ian Kent <raven@themaw.net>
Subject: Re: user token
Date: Tue, 27 Nov 2007 11:17:24 +0900
Message-ID: <1196129844.3973.16.camel@raven.themaw.net>
References: <4a3f02760711260149g1f5be5f9q9fcd2ea5d364b95@mail.gmail.com>
	<1196101382.3381.7.camel@raven.themaw.net> <474B1E0E.3040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <474B1E0E.3040505@gmail.com>
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
To: muzzol <muzzol@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-11-26 at 20:27 +0100, muzzol wrote:
> En/na Ian Kent ha escrit:
> > On Mon, 2007-11-26 at 10:49 +0100, muzzol wrote:
> > No other parameters can be passed to program maps.
> > I don't really know of a sane way to do this.
> > 
> 
> is this by design?

It's been that way since before I took over maintenance of autofs.

> 
> do you plan to add such feature in the future?

Like I said, I don't see any "sane" way to do this.
There is a way to use an external environment variable withing maps but
I haven't looked at that code for some time now.

What is it that you need that the standard environment I mentioned
doesn't provide?

Ian
