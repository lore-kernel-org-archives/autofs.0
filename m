From: Simon Gao <gao@schrodinger.com>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Thu, 06 Sep 2007 15:44:01 -0700
Message-ID: <46E082B1.7060909@schrodinger.com>
References: <46DE1128.2020109@oracle.com>	<1188994602.3119.5.camel@raven.themaw.net>	<46DEEAC4.80100@schrodinger.com>	<1189048182.3102.5.camel@raven.themaw.net>
	<x49myvzvoqs.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49myvzvoqs.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
>
>   
>> On Wed, 2007-09-05 at 10:43 -0700, Simon Gao wrote:
>>     
>>> I also have a related question about basedn in /etc/sysconfig/autofs.
>>>
>>> You can put in root level basedn like "dc=example,dc=com", or more lower
>>> level like "ou=autofs,ou=services,dc=example,dc=com". Would later case
>>> help the search by being more specific and therefore getting autofs map
>>> lot quicker? Or it makes not significant difference?
>>>       
>> This configuration option is RHEL4 specific.
>> I would need to revisit that code to answer that.
>> Perhaps Jeff will be able to help.
>>     
>
> Well, since it is the search base, yes, confining it more will limit
> the scope of the search.
>
> -Jeff
>   
So for autofs 5.0.1 on RHEL 5, one can add basedn line to
/etc/sysconfig/autofs? Just curious what's the reason to remove it or
not include it as default in the first place?

Simon
