From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 22:48:07 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502152247360.8175@donald.themaw.net>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
	<16913.64816.599846.407333@segfault.boston.redhat.com>
	<20050215140206.GA26192@uio.no>
	<16914.1782.404548.771512@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16914.1782.404548.771512@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 15 Feb 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] [ANNOUNCE] autofs 4.1.4 beta2 release; "Steinar H. Gunderson" <sgunderson@bigfoot.com> adds:
>
> sgunderson> On Tue, Feb 15, 2005 at 08:46:24AM -0500, Jeff Moyer wrote:
>>> Could you post this patch, please?  I'm almost certain this fix is in the
>>> tree.
>
> sgunderson> http://home.samfundet.no/~sesse/000_autofs_4.1.3_sock-leak-fix
>
> We solved this problem a different way.  If we pass RPC_ANYSOCK to the
> portmapper, it will use a reserved port by default for communications.  To
> keep it from doing that, we create the socket ourselves.  We then do this:
>
>                clnt_control(client, CLSET_FD_CLOSE, NULL);
>
> Which tells the rpc layer to close the socket for us when we destroy the
> client.  As such, there is no socket leak.

Yep. The patch was a bit out of date.

Thanks Jeff.

Ian
