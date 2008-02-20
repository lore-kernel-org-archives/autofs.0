From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: Re: Debian Etch autofs-ldap tutorial ?
Date: Wed, 20 Feb 2008 14:22:31 +0100
Message-ID: <47BC2997.9020701@ant.uni-bremen.de>
References: <47BC1BE6.8030309@esiee.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47BC1BE6.8030309@esiee.fr>
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
To: Frank Bonnet <f.bonnet@esiee.fr>
Cc: autofs@linux.kernel.org

Frank Bonnet wrote:
> Hello
> 
> I need such tutorial I found some, but it seems a bit fuzzy for me
> 
> I'm still in trouble with the message
> 
> no automount maps defined

could be as simple as a forgotten

automount:     ldap

in /etc/nsswitch.conf

-Heinrich
