From: Peter Staubach <staubach@redhat.com>
Subject: Re: autofs illustrations
Date: Wed, 08 Nov 2006 08:29:30 -0500
Message-ID: <4551DBBA.40004@redhat.com>
References: <200611072124.kA7LOTES005928@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200611072124.kA7LOTES005928@cs.utexas.edu>
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
To: Fletcher Mattox <fletcher@cs.utexas.edu>
Cc: autofs@linux.kernel.org

Fletcher Mattox wrote:
>> Fletcher Mattox wrote:
>> ...
>>     
>>> Unprivileged ports and/or UDP are not viable options for us, so I am
>>> forced to increase the timeout from 5 minutes to 24 hours, which in
>>> practice means they are always mounted.  We have about 400 automounted
>>> filesystems, so the only long term solution for us is to try to coalesce
>>> them to less than 100.  Very painful.
>>>       
>> You have 400 automounted file systems, all of which need to be mounted at
>> the same time?  
>>     
>
> Not all of them, but certainly more than 100 of them, which seems to
> be the limit we are talking about. 
>
>   

Hmm.  Perhaps Chuck Lever's work to reduce the number of required TCP
connections would help in this sort of deployment.

>> If so, I might suggest that static mounts might better serve
>> your needs.  
>>     
>
> Really?  I think this is the first time I have ever heard someone
> advocate static mounts as a solution to a large number of filesystems
> (especially ones that tend to appear and disappear frequently).
> But you are right, and this is effectively the solution we arrived at
> by increasing the timeout.
>
>   

Well, if the file systems tend to get mounted and then stay mounted,
then automounting does little good and can be harmful.

Automounting also does not tend to work well with large numbers of
file systems and not always for the scalability reasons which are
being seen here.
>> Or, rethink the application and deployment.
>>     
>
> I think that's what said in my penultimate sentence. :)

Yup...  :-)

       ps
