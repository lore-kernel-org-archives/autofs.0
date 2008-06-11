From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount ignores remote logins
Date: Wed, 11 Jun 2008 10:09:45 -0400
Message-ID: <x49k5gw83me.fsf@segfault.boston.devel.redhat.com>
References: <9e9c61c30806050816l18e0cf5ao973cb3332ee9b9d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9e9c61c30806050816l18e0cf5ao973cb3332ee9b9d2@mail.gmail.com>
	(Max Harvest's message of "Thu, 5 Jun 2008 17:16:22 +0200")
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
To: Max Harvest <rootserver94@googlemail.com>
Cc: autofs@linux.kernel.org

"Max Harvest" <rootserver94@googlemail.com> writes:

> Hello everybody,
>
> since i'm using the automount 5, i'm confronted with a very strange
> behaviour. I use it to mount user directories over nfs. The automounter

Are you saying that you did not experience this problem with autofs v4?

> maps are provided by NIS und users ususally have to login only into
> client computers remotely using rsh or ssh. Now i encounter the following
> missbehaviour:
>
> At the init, automounter seems to start propperly, but if someone logins
> over the network into the client machine, the automounter ignores all
> mount requests (i.e. there is no automounter activity at all). Even a

This is probably because there is no lookup performed (meaning it never
gets to autofs).  What errors are displayed in the ssh session when a
user logs in?  Is there anything in /var/log/secure or /var/log/messages
that may indicate a problem elsewhere?

-Jeff
