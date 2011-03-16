From: Nye Liu <nyet@mrv.com>
Subject: Re: "Use bind instead of nfs if host is localhost" feature
 is broken? removed?
Date: Wed, 16 Mar 2011 15:42:41 -0700
Message-ID: <20110316224241.GA30815@mrv.com>
References: <20110310235943.GA19588@mrv.com> <1299979935.2906.5.camel@perseus>
	<4D7FF5D2.3080107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D7FF5D2.3080107@zytor.com>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On 3/15/2011 4:27 PM, H. Peter Anvin wrote:
> On 03/12/2011 05:32 PM, Ian Kent wrote:
>> On Thu, 2011-03-10 at 15:59 -0800, Nye Liu wrote:
>>> I have been relying on the behavior that
>>>
>>> foo	host:/export/foo
>>>
>>> uses 'bind' if host is localhost, and 'nfs' otherwise...
>>>
>>> i.e. if i am on the machine "host", /export/foo is mounted on /mnt/foo using
>>> bind, but if i am not on "host", host:/export/foo is mounted on /mnt/foo
>>> using nfs.
>>>
>>> But the latest version of autofs no longer does that.
>>
>> What latest version?
>>
>
> I believe this is related to a change in the network layer in Linux,
> which breaks the localhost test not just for autofs but for almost any
> application which uses the same, portable technique for determining the
> localness of a host address.


Indeed. /etc/hosts had "127.0.0.1 host", and not the "real" ip matching dns.

I changed /etc/hosts from 127.0.0.1 to its real ip, and autofs now 
properly detects that "host" is local and uses bind now, as it should. I 
verified this has nothing to do with autofs version and more to do with 
kernel revision.

2.6.32 "works", 2.6.37 is "broken".
