From: Ian Kent <raven@themaw.net>
Subject: Re: How to make Autofs check if ldap server is back online
Date: Tue, 15 Dec 2009 09:23:11 +0800
Message-ID: <4B26E4FF.80908@themaw.net>
References: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
	<BLU135-W27268A9EEAD4CF84BBA96DC8D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BLU135-W27268A9EEAD4CF84BBA96DC8D0@phx.gbl>
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
To: "Eric B." <ebenze@hotmail.com>
Cc: autofs@linux.kernel.org

Eric B. wrote:
> 
> "Ian Kent" <raven@themaw.net> wrote in message 
> news:4B18C1D7.7020703@themaw.net...
>> Eric B. wrote:
>>> Hi,
>>>
>>> I'm using Autofs and LDAP for mounting my home directories via nfs.
>>> In general, everything seems to work fine.  However, I have one small
>>> problem.
>>>
>>> If I reboot my server using autofs while my LDAP server is down, I
>>> get the following error message in my logs: automount[3358]:
>>> bind_ldap_anonymous: lookup(ldap): Unable to bind to the LDAP server:
>>> (default), error Can't contact LDAP server
>>>
>>> which is understandable, since my ldap server is temporarily down.
>>>
>>> My problem, however, is that once my ldap server is back up, autofs
>>> never seems to retry to connect to it, so all my /home mounts fail.
>>> Basically, it means I have to make sure that my LDAP server is never
>>> down while another server is rebooting.
>>>
>>> I figure there must be something in the configuration file that would
>>> allow me to tweak this to indicate to autofs to recheck the ldap
>>> server periodically to see if it has come back up, but can't seem to
>>> find anything.
>> Yeah, there are problems in that area.
>>
>> What does your nsswitch.conf have for the "automount:" entry?
>> Is your master map also located on the LDAP server?
>> Does sending a HUP signal to automount make things work again when the
>> server is back?
> 
> 
> nsswitch.conf:
> automount:  files ldap
> 
> Restarting autofs will make things work again.  Similarly, issuing a HUP 
> signal will make things work again once the server is back online.
> 
> Thanks for any suggestions.

Right, I've started working on this.
But if your master map is also in LDAP then your stuck until I work out
how to deal with the problem.

Ian
