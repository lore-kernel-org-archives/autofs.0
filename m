From: Ian Kent <raven@themaw.net>
Subject: Re: Problems creating RPM out of tar (5.0.5)
Date: Wed, 01 Dec 2010 22:00:29 +0800
Message-ID: <1291212029.2706.3.camel@perseus.themaw.net>
References: <4CF613EC.9040702@mathematik.uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4CF613EC.9040702@mathematik.uni-mainz.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Holger Schier <hschier@mathematik.uni-mainz.de>
Cc: autofs@linux.kernel.org

On Wed, 2010-12-01 at 10:22 +0100, Holger Schier wrote:
> Hey folks,
> 
> I am working with openSuSE 11.1 and 11.2 here and because of a new
> server I need an automounter with simple bind options. So I downloaded
> the 5.0.5 tar and do all the patching. Then I created a new tar and tried:
> 
> rpmbuild -tb autofs-5.0.5.-patched.tar.gz
> 
> But I get the following errors:
> failed build dependencies
> hesiod-devel is needed by autofs-5.0.5-1.src
> openldap-devel is needed by autofs-5.0.5-1.src
> 
> Same error with the orginial tar.
> 
> openldap2-devel is installed (with YaST). I don't know what hesiod is
> and didn't find any rpms. And the autofs-5.0.4 rpm installation before
> was working.
> 
> So, where does these dependencies come from?

If you look in the spec file you will see.
BuildPrereq: autoconf, hesiod-devel, openldap-devel, bison, flex, cyrus-sasl-devel

If the packages that provide these facilities have different names
within your distribution you will need to change them. Why don't you
have a look at the original openSuSE source rpm and see what it uses.

> 
> Thanks.
> Holger
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
