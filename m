From: Ian Kent <raven@themaw.net>
Subject: Re: hostname lookup failed: Operation not permitted
Date: Tue, 16 Oct 2007 16:17:26 +0800
Message-ID: <1192522647.4443.17.camel@raven.themaw.net>
References: <47133BB6.5010903@int-edu.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47133BB6.5010903@int-edu.eu>
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
To: "jehan.procaccia" <jehan.procaccia@int-edu.eu>
Cc: autofs mailing list <autofs@linux.kernel.org>, "Eric. Doutreleau" <eric.doutreleau@int-evry.fr>

On Mon, 2007-10-15 at 12:06 +0200, jehan.procaccia wrote:
> Hello,
> 
> I have several users that cannot automount their homdir . The logs says:
> 
> Oct 14 15:56:47 anaconda automount[10054]: create_udp_client: hostname 
> lookup failed: Operation not permitted
> Oct 14 15:56:47 anaconda automount[10054]: create_tcp_client: hostname 
> lookup failed: Operation not permitted
> Oct 14 15:56:47 anaconda automount[10054]: lookup_mount: exports lookup 
> failed for .directory
> Oct 14 16:01:19 anaconda automount[10054]: create_udp_client: hostname 
> lookup failed: Operation not permitted
> Oct 14 16:01:19 anaconda automount[10054]: create_tcp_client: hostname 
> lookup failed: Operation not permitted
> Oct 14 16:01:19 anaconda automount[10054]: lookup_mount: exports lookup 
> failed for ipv4
> Oct 14 16:01:19 anaconda automount[10054]: create_udp_client: hostname 
> lookup failed: Operation not permitted
> Oct 14 16:01:19 anaconda automount[10054]: create_tcp_client: hostname 
> lookup failed: Operation not permitted

A missing /etc/hosts file can cause this error.

Ian
