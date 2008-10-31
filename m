From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 17:28:53 +0900
Message-ID: <1225441733.2946.102.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225436514.2946.74.camel@zeus.themaw.net>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
	<1225438359.2946.82.camel@zeus.themaw.net>
	<510ca9b40810310052o2c418ec5sd47c9d3b056a894d@mail.gmail.com>
	<1225440162.2946.93.camel@zeus.themaw.net>
	<510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2008-10-31 at 19:10 +1100, Paul Wankadia wrote:
> On Fri, Oct 31, 2008 at 7:02 PM, Ian Kent <raven@themaw.net> wrote:
> 
> > But I don't get a syntax error for the input that your mail specifies.
> 
> If you make with flex --debug, what output do you see when automount starts?

No debug info at all.
Debug is possibly disabled in the package build.
I'll need to investigate.

> 
> Honestly, I have no idea why it scans a DNSTR for me, but as I
> mentioned, I have to work around it by escaping 'c' and 'o' with
> backslashes. When were those lex rules last modified?

Yes, this part of the lex code has had recent changes so there's every
chance it is a bit broken or possibly flex is working differently
between our machines.

Ian
