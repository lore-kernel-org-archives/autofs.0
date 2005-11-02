From: Dannie Stanley <dannie.stanley@gmail.com>
Subject: Re: autofs timeout and large map
Date: Wed, 2 Nov 2005 10:53:43 -0500
Message-ID: <89e9feae0511020753x16d99a30rd0713ec37136f16@mail.gmail.com>
References: <20051028163028.75072c9b.akpm@osdl.org>
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net>
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
	<Pine.LNX.4.63.0511022249510.3305@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511022249510.3305@donald.themaw.net>
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

Ian:

I am glad you were able to find the bug.  The work around I am
currently using works ok for now so I probably won't change my
configuration.  Though I appreciate the effort to give me other
options.

Thanks,
Dannie

On 11/2/05, Ian Kent <raven@themaw.net> wrote:
> On Mon, 31 Oct 2005, Dannie Stanley wrote:
>
> > >
> > > I have generated a DIRECT map file and defined it in /etc/auto.master.
> > >  My direct mappings look like this (located in /etc/auto.virtual):
>
> Ummmm ....
>
> Oops looks like there's a check that stop this from working correctly for
> direct mounts.
>
> There was probably a reason for it so let me think about it for a bit and
> I'll put together a patch.
>
> In the mean time you could work around this using an indirect map like:
>
> In the master:
>
> /virtual        /etc/auto.virtual
>
> In auto.virtual:
>
> USERNAME /public localhost:/dir1 /private localhost:/dir2
>
> for each of your USERNAME entries.
>
> or you could use a direct map like:
>
> /virtual/USERNAME/private localhost:/dir1
> /virtual/USERNAME/public localhost:/dir2
>
> for each of your USERNAME entries.
>
> Ian
>
>


--
Dannie M. Stanley

"The Feynman Problem-Solving Algorithm: (1) write down the problem;
(2) think very hard; (3) write down the answer." - Murray Gell-Mann
