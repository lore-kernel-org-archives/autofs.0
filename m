From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Problems creating RPM out of tar (5.0.5)
Date: Fri, 10 Dec 2010 10:37:25 -0200
Message-ID: <AANLkTi==6pjvpktsPrccTAqRD8Dvcnze2z7Vc72VTZfY@mail.gmail.com>
References: <4CF613EC.9040702@mathematik.uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:in-reply-to
	:references:date:message-id:subject:from:to:cc:content-type;
	bh=iIocbq3+BDh85nUHyP/Qj6iVZGfVNgUmpwdjLKcjeRA=;
	b=c8Y3cHTRtNs829E9eZ8utZVBtTdguenE3/BGi4jFpueuFGA2GgzDLaJn99dhjgFmSe
	FKtO8YBTsyjK1D05LU9f6AiRj5l8FjvLrmupXHWCBAlqOfW1T3/eYp7kNqSLzAueCyAA
	dJ59v4al/IoFNR+ep95J2B+DmfDYkSmu+ZDgk=
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

On Wed, Dec 1, 2010 at 7:22 AM, Holger Schier
<hschier@mathematik.uni-mainz.de> wrote:
> Hey folks,
>
> I am working with openSuSE 11.1 and 11.2 here and because of a new
> server I need an automounter with simple bind options. So I downloaded
> the 5.0.5 tar and do all the patching. Then I created a new tar and tried:
>
> rpmbuild -tb autofs-5.0.5.-patched.tar.gz

Hello Holger,

Alternatively, you can use the packages from the Build Service filesystems
repository.

openSUSE 11.1:

http://download.opensuse.org/repositories/filesystems/openSUSE_11.1/i586/autofs-5.0.5-20.2.i586.rpm
http://download.opensuse.org/repositories/filesystems/openSUSE_11.1/x86_64/autofs-5.0.5-20.2.x86_64.rpm

openSUSE 11.2:

http://download.opensuse.org/repositories/filesystems/openSUSE_11.2/i586/autofs-5.0.5-20.1.i586.rpm
http://download.opensuse.org/repositories/filesystems/openSUSE_11.2/x86_64/autofs-5.0.5-20.1.x86_64.rpm

These are the latest (Factory) version rebuilt on 11.1 and 11.2

Leonardo
