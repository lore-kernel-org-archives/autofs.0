From: Dannie Stanley <dannie.stanley@gmail.com>
Subject: Re: autofs timeout and large map
Date: Tue, 1 Nov 2005 13:24:05 -0500
Message-ID: <89e9feae0511011024y73ec0d2bn86a486d63b8e357b@mail.gmail.com>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
	<89e9feae0511010451we3f1d43g8c8d3caf0efceb0@mail.gmail.com>
	<Pine.LNX.4.63.0511020005090.3040@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511020005090.3040@donald.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Thanks for the feedback.  Here is my answer to your last question:

$ lsmod |grep fs
autofs4                15864   1  (autoclean)

I am assuming it is safe to skip the debug steps since Jeff Moyer has
assisted in this diagnosis -- Thanks Jeff!

-- Dannie


On 11/1/05, Ian Kent <raven@themaw.net> wrote:
> On Tue, 1 Nov 2005, Dannie Stanley wrote:
>
> > I performed some testing in the early morning hours and this is what I
> > found.  The problem seems to be with the --ghost option.  When I
> > specify this in my auto.master:
> >
> >    /- /etc/auto.virtual --ghost
> >
> > I get the originally reported errors.  When I remove the --ghost
> > option it seems to work as expected.
> >
>
> Btw there are two kernel modules, autofs and autofs4, which do you have
> loaded?
>
> You can find out with an lsmod. You'll see either autofs or autofs4.
>
> Ian
>
>


--
Dannie M. Stanley

"The Feynman Problem-Solving Algorithm: (1) write down the problem;
(2) think very hard; (3) write down the answer." - Murray Gell-Mann
