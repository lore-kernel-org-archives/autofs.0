From: Ian Kent <raven@themaw.net>
Subject: Re: another make issue
Date: Mon, 03 Nov 2008 11:38:31 +0900
Message-ID: <1225679911.2911.35.camel@zeus.themaw.net>
References: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
	<1225676646.2911.4.camel@zeus.themaw.net>
	<510ca9b40811021805o2eb86f11x3b0eff0f676a8e22@mail.gmail.com>
	<1225678804.2911.24.camel@zeus.themaw.net>
	<510ca9b40811021833n4295cbeai5775ca17c8146727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40811021833n4295cbeai5775ca17c8146727@mail.gmail.com>
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

On Mon, 2008-11-03 at 13:33 +1100, Paul Wankadia wrote:
> On Mon, Nov 3, 2008 at 1:20 PM, Ian Kent <raven@themaw.net> wrote:
> 
> >> FWIW, I'm using Ubuntu.
> >
> > And you don't have a directory /etc/conf.d, has that changed somehow,
> > does it not exist at your build time?
> 
> No, /etc/default/ appears to be the directory that other packages are using.

Oh .. of course, Ubuntu is a Debian variant, sorry.

I think I've used /etc/defaults, thinking that was the Debian based
location, but maybe there was another reason for that as well, I'll
add /etc/default to the list.

Ian
