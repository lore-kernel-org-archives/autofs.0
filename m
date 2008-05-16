From: Ian Kent <raven@themaw.net>
Subject: Re: sasl with heimdal kerberos
Date: Fri, 16 May 2008 11:03:58 +0800
Message-ID: <1210907038.3151.26.camel@raven.themaw.net>
References: <482C4260.3090308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482C4260.3090308@gmx.net>
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
To: autofs@linux.kernel.org, Martin von Gagern <Martin.vGagern@gmx.net>


On Thu, 2008-05-15 at 16:02 +0200, Martin von Gagern wrote:
> Hi!
> 
> I'm using Gentoo Linux with autofs-5.0.3, cyrus-sasl-2.1.22 and heimdal
> 0.7.2. I got compile time error messages when trying to compile autofs
> with sasl support. I reported them as https://bugs.gentoo.org/210762
> 
> Today I was made aware that the same issues were already mentioned on
> this mailing list here, in a thread titled "sasl compilation error"
> http://www.mail-archive.com/autofs@linux.kernel.org/msg06165.html
> 
> I just had a closer look at this, and found two useful macros defined in
> the heimdal headers, called krb5_realm_length and krb5_realm_data. MIT
> kerberos doesn't seem to define them, but a simple preprocessor siwtch
> is enough to introduce them in a MIT-compatible fashion.

Interesting.

> 
> With this I created a patch that causes autofs to compile on my system,
> and which I would expect to compile for all sane Heimdal and MIT setups,
> and to work correctly as well. Be warned, though, that I haven't got any
> real Kerberos set up here, so I didn't actually test that things work.

It would be good if someone could check this out.

Ian
