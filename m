From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: sshfs and autofs
Date: Fri, 25 Dec 2009 00:52:42 +0100
Message-ID: <1261698589-sup-7513@nixos>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl> <1261518309-sup-4721@nixos>
	<4B329000.3060101@bononline.nl> <4B3292D4.5040106@bononline.nl>
	<1261606324-sup-8574@nixos> <4B329A33.5000901@bononline.nl>
	<1261608555-sup-8913@nixos> <4B3376E9.2040403@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4B3376E9.2040403@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs <autofs@linux.kernel.org>

Hi Stef,

You don't have to put any further effort into this.
The solution I found is working for me.

The keypoint about ssh passwords is that you don't store them on disk.
So if anyone get's access to your filesystem (or disk) he still can't
use the key.

What you describe is used to keep samba passwords up to date AFAIK.

I'd rather spend time on updating the HOWTO or creating a wiki.
But I don't know how to contact the maintainer. I wrote that in another
mail recently..

Marc Weber
