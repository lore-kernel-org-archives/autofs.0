From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 15:53:15 +0900
Message-ID: <1225435995.2946.72.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225434594.2946.53.camel@zeus.themaw.net>
	<510ca9b40810302349i7774f3a8q3ca46951cad3c444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810302349i7774f3a8q3ca46951cad3c444@mail.gmail.com>
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

On Fri, 2008-10-31 at 17:49 +1100, Paul Wankadia wrote:
> On Fri, Oct 31, 2008 at 5:29 PM, Ian Kent <raven@themaw.net> wrote:
> 
> > Yeah, I've obviously broken that at some point.
> > I've uploaded a patch to kernel.org just now that should fix that.
> > autofs-5.0.3-fix-datarootdir-define.patch
> 
> Thank you.
> 
> What about the auto.master syntax error?

Haven't got to that yet.

But I don't see that here (well, maybe I may have broken something
though) so I'll need to do a build from a new git checkout myself and
see.

Ian
