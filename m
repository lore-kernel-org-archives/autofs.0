From: Ian Kent <raven@themaw.net>
Subject: Re: Dynamically reloading autofs maps (was: RE: How to
 make Autofs check if LDAP server is back online?)
Date: Fri, 04 Dec 2009 16:19:23 +0800
Message-ID: <4B18C60B.2080803@themaw.net>
References: <1259772801.4945.58.camel@psmith-ubeta.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1259772801.4945.58.camel@psmith-ubeta.netezza.com>
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
To: paul@mad-scientist.net
Cc: autofs@linux.kernel.org

Paul Smith wrote:
> Eric B. writes:
>> My problem, however, is that once my ldap server is back up, autofs
>> never seems to retry to connect to it, so all my /home mounts fail.
>> Basically, it means I have to make sure that my LDAP server is never
>> down while another server is rebooting.
> 
> [[Sorry for the missing threading headers--I'm switching accounts right
> now]]
> 
> This is related to a larger issue, I think: is there any effort anywhere
> to make autofs dbus/NetworkManager aware?  I've ranted elsewhere about
> the poor design of NM, which basically requires every other network
> service, even those that have existed for tens of years before Linux
> itself, to be modified to conform to NM's idea of how dynamic network
> configuration should work.  However no one seems to care and at this
> point it seems like autofs is about the only commonly-used facility that
> doesn't integrate with NM.  Even ypbind (NIS) has been modified to
> support NM.
> 
> Today on my Ubuntu systems the only thing that doesn't work properly is
> autofs: when my system comes up and services are started, they all wait
> for the network interface to come up and to be notified by NM that the
> interface is available, before going further.
> 
> All, that is, except autofs: the OP above only has this problem if his
> LDAP server happens to be down when he reboots, but on Ubuntu systems
> (at least) where automount maps are distributed by NIS, I have this
> problem every single time I boot my system.  Because NIS is not
> available/ready when autofs comes up, the retrieval of the automount
> maps from NIS fails, so when autofs comes up it has no distributed maps.
> 
> I have to, by hand, restart autofs so it can see the maps.
> 
> What would be nice is if autofs could be listening for some kind of
> "network directory services (re)started" dbus message or something, that
> could be sent by LDAP, NIS, and whatever else, and which would cause
> autofs to reread its configuration.  Today the autofs configuration from
> LDAP/NIS is done via the init script so that's a complication...
> 
> What can be done about this?  Anyone have any ideas on how to make this
> work better?

So where is the documentation for the interfaces you mention?

Ian
