From: "Paul Wankadia" <junyer@gmail.com>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 22:15:15 +1100
Message-ID: <510ca9b40810310415l667b803bya357f07f11312ff3@mail.gmail.com>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225436514.2946.74.camel@zeus.themaw.net>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
	<1225438359.2946.82.camel@zeus.themaw.net>
	<510ca9b40810310052o2c418ec5sd47c9d3b056a894d@mail.gmail.com>
	<1225440162.2946.93.camel@zeus.themaw.net>
	<510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
	<1225442150.2946.105.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225442150.2946.105.camel@zeus.themaw.net>
Content-Disposition: inline
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, Oct 31, 2008 at 7:28 PM, Ian Kent <raven@themaw.net> wrote:

> Yes, this part of the lex code has had recent changes so there's every
> chance it is a bit broken or possibly flex is working differently
> between our machines.

Have you ever considered the merits of unit tests? :)

On Fri, Oct 31, 2008 at 7:35 PM, Ian Kent <raven@themaw.net> wrote:

> Just a stab in the dark but what happens if you apply this patch, just
> adding the brackets?

Well, parentheses are used to override precedence, so the patterns are
effectively unchanged.
