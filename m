From: Ian Kent <raven@themaw.net>
Subject: Re: parsing issue in master map file: tabs works,
	space	don't
Date: Thu, 24 Jan 2008 14:36:14 +0900
Message-ID: <1201152974.3061.34.camel@raven.themaw.net>
References: <47977DAB.5030207@inria.fr>
	<1201139305.3061.1.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1201139305.3061.1.camel@raven.themaw.net>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org


On Thu, 2008-01-24 at 10:48 +0900, Ian Kent wrote:
> On Wed, 2008-01-23 at 18:47 +0100, Guillaume Rousse wrote:
> > See
> > http://qa.mandriva.com/show_bug.cgi?id=37107 for details.
> > 
> > I reproduced the issue myself.
> 
> Please check the patches on kernel.org.

In fact please try
http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.3-basedn-with-spaces-fix-3.patch

This patch was just updated as it wasn't quite right.

Ian
