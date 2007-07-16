From: Rich West <Rich.West@wesmo.com>
Subject: Re: autofs5 + ldap + ldap replication
Date: Mon, 16 Jul 2007 14:28:15 -0400
Message-ID: <469BB8BF.3010404@wesmo.com>
References: <469985DF.9010607@wesmo.com> <4699DB66.70602@int-edu.eu>
	<469A39D5.8040304@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <469A39D5.8040304@wesmo.com>
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

The autofs5 client doesn't seem to have a problem connecting to the
master LDAP server.  It is only having problems connecting to the
replica (and yes, I do have those settings).

As I dug in to it further, it is definitely the case where only autofs5
can't get its maps from the replica server.  All other things (password
auth, etc) work fine with the master and the replica..  Our autofs4
clients happily work with the master and/or the replica.

-Rich

>
>> Isn't it the problem of defining which attributes to use in
>> automountmap ?
>> I had this resolved (in fedora 7) by uncommenting the necessary
>> attributes in /etc/sysconfig/autofs , have you check that ?
>>
>> in /etc/sysconfig/autofs for mine autofs ldap maps I had to uncomment
>> these:
>>
>> # Other common LDAP nameing
>> #
>> MAP_OBJECT_CLASS="automountMap"
>> ENTRY_OBJECT_CLASS="automount"
>> MAP_ATTRIBUTE="ou"
>> ENTRY_ATTRIBUTE="cn"
>> VALUE_ATTRIBUTE="automountInformation"
>>
>
>
