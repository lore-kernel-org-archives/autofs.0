From: Simon Gao <gao@schrodinger.com>
Subject: Re: basedn in /etc/sysconfig/autofs
Date: Wed, 05 Sep 2007 10:43:32 -0700
Message-ID: <46DEEAC4.80100@schrodinger.com>
References: <46DE1128.2020109@oracle.com>
	<1188994602.3119.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1188994602.3119.5.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Wed, 2007-09-05 at 10:15 +0800, wengang wang wrote:
>   
>> Hi,
>> A custom complained that:
>> //<==
>> In RHEL4 it was possible to set a "basedn" variable in the
>> /etc/sysconfig/autofs file which served as a basedn for LDAP lookups
>> performed by the automounter.
>>
>> However, this has been removed in RHEL5.
>> //<==
>> It is true that setting it in /etc/openldap/ldap.conf is an alternative, 
>>     
>
> No.
>
>   
>> the custom doesn't want do as that because /etc/openldap/ldap.conf is 
>> automatically edited by the redhat config tools authconfig and 
>> system-config-authentication.
>> So I want to know for what the basedn is removed from 
>> /etc/sysconfig/autofs.  I checked all the change logs and readmes in 
>> autofs-5.0.1, but didn't find basedn metioned.
>>     
>
> In version 5 the base dn is calculated, depending on how you specify the
> map.
>
> Describe the problem and I'll try and give a sensible answer.
>
> Ian
>   
I also have a related question about basedn in /etc/sysconfig/autofs.

You can put in root level basedn like "dc=example,dc=com", or more lower
level like "ou=autofs,ou=services,dc=example,dc=com". Would later case
help the search by being more specific and therefore getting autofs map
lot quicker? Or it makes not significant difference?

Simon
