From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.2 (and 5.0.3) keep segfaulting
Date: Thu, 12 Jun 2008 21:09:52 +0800
Message-ID: <1213276193.4994.124.camel@raven.themaw.net>
References: <1213268830.10126.8.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213268830.10126.8.camel@vesuv.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org


On Thu, 2008-06-12 at 13:07 +0200, Lukas Kolbe wrote:
> Hi List,
> 
> about twice a day, autofs keeps segfaulting on our main mailhub:
> 
> Jun 12 12:53:38 mailin automount[12008]: parse_mount: parse(sun): expanded entry: :/users/stud01/stud/juser

What is actually in your map for this entry?

Ian
