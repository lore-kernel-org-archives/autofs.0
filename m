From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: unable to locate ldap master map
Date: Fri, 25 Aug 2006 19:26:28 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608251925040.30523@raven.themaw.net>
References: <E1GGZdt-0002fb-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGZdt-0002fb-00@mta2.cl.cam.ac.uk>
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
To: Piete Brooks <Piete.Brooks@cl.cam.ac.uk>, Piete.Brooks--autofs@cl.cam.ac.uk
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 25 Aug 2006, Piete Brooks wrote:

> > Complains about doing too many queries to the server is why it's this way.
> 
> Fine -- I can live with a single lookup.
> 
> > For people with large maps trying all three schema would be a killer.
> 
> As a naive LDAP user, I assumed that such a simple request would be trivial :-(

Sure, it's not hard to do but if you have a bunch of clients querying an 
LDAP server a times 3 work load isn't good.

Ian
