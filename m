From: "Paul Wankadia" <junyer@gmail.com>
Subject: Re: another make issue
Date: Mon, 3 Nov 2008 13:05:07 +1100
Message-ID: <510ca9b40811021805o2eb86f11x3b0eff0f676a8e22@mail.gmail.com>
References: <510ca9b40811021718j43583340p38cec31f35cc87ff@mail.gmail.com>
	<1225676646.2911.4.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225676646.2911.4.camel@zeus.themaw.net>
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

On Mon, Nov 3, 2008 at 12:44 PM, Ian Kent <raven@themaw.net> wrote:

> Yeah, but there's an assumption that at least one of the directories
> that is checked will exist on any system, which is obviously wrong. I
> could add /etc to the end of the list but, really what we need is a list
> of appropriate directories for various distributions, so if I do that
> I'll never find out what they are.

If you follow the FHS, then you can let package maintainers worry
about anything specific to their distributions.

> What distribution are you using?

FWIW, I'm using Ubuntu.
