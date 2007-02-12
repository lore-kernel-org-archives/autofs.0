From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP automountMap or nisMap
Date: Mon, 12 Feb 2007 11:37:14 +0900
Message-ID: <1171247834.18376.1.camel@raven.themaw.net>
References: <10badf220702092315xa680710i211a575d4117297d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220702092315xa680710i211a575d4117297d@mail.gmail.com>
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
To: Shane <squindler@gmail.com>
Cc: autofs@linux.kernel.org

On Sat, 2007-02-10 at 17:45 +1030, Shane wrote:
> Hey All,
> 
> I've been googling around trying to find out what is the "better"
> option between using LDAP automountMap's or nisMap's. I can get either
> / both working, the question is more for being able to find / get good
> support should we need it, which of these maps is the preferred map to
> use by autofs? ...does the answer change between autofs 3 and 4?

There's more than one variant of the automountMap type.
I believe the rfc2307bis is the most recent.

Ian
