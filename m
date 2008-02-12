From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: mount options can not be parsed in auto.master with
	ldap map
Date: Tue, 12 Feb 2008 15:46:25 -0700
Message-ID: <fot7k2$u9a$1@ger.gmane.org>
References: <m3hchbdqxc.fsf@dynamo.mandriva.com>	<1200885843.10357.40.camel@raven.themaw.net>
	<m3odbfpnom.fsf@dynamo.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <m3odbfpnom.fsf@dynamo.mandriva.com>
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
To: autofs@linux.kernel.org

Olivier Blin wrote:
> Ian Kent <raven@themaw.net> writes:
> 
>> On Fri, 2008-01-18 at 17:44 +0100, Olivier Blin wrote:
>>> It fails this way:
>>> # automount -d -f
>>> Starting automounter version 5.0.3, master map auto.master
>>> using kernel protocol version 5.00
>>> lookup_nss_read_master: reading master files auto.master
>>> parse_init: parse(sun): init gathered global options: (null)
>>> lookup_read_master: lookup(file): read entry /home
>>> syntax error in map near [ nosuid ]
>>> no mounts in table
>> Please give this patch a try
>> http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.3-basedn-with-spaces-fix-3.patch
> 
> It works great, thanks a lot!
> 

Lucky me, I ran into this with Fedora 8 just as I'm testing our 
migration to LDAP.  Will we see an update for F8 soon?


-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA/CoRA Division                    FAX: 303-415-9702
3380 Mitchell Lane                  orion@cora.nwra.com
Boulder, CO 80301              http://www.cora.nwra.com
