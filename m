From: Stef Bon <stef@bononline.nl>
Subject: Re: sshfs and autofs
Date: Wed, 23 Dec 2009 22:59:48 +0100
Message-ID: <4B3292D4.5040106@bononline.nl>
References: <1261107485-sup-320@nixos>
	<1261173402-sup-9510@nixos>	<4B2E48C7.8010509@bononline.nl>
	<1261391275-sup-7258@nixos>	<4B311928.9070503@bononline.nl>
	<1261518309-sup-4721@nixos> <4B329000.3060101@bononline.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B329000.3060101@bononline.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Stef Bon wrote:
>
>
> This is the whole problem, because this is not easy. The automounter 
> (read man 5 autofs) can offer variables like USER, UID, etc,HOST
> of the user requesting the mount (according to the manpage). Then to 
> present this user a suitable dialog... maybe via dbus???

I'm silly here, the user is not the problem, this is already available, 
in the options, or - in my construction - in the config file, in the 
parameter AUTOFS_USER
and in the mountpath, but the environment this user is using! A pid of 
the process would be very usefull, for example.
But this is not easy. When I'm logged in twice with the same account, 
which session should get the question for the passphrase?

Stef
