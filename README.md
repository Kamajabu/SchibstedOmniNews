<h1 class="code-line" data-line-start=0 data-line-end=1 ><a id="OmniNews_0"></a>OmniNews</h1>
<p class="has-line-data" data-line-start="1" data-line-end="2">Recruitment task</p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Plugin</th>
<th>README</th>
</tr>
</thead>
<tbody>
<tr>
<td>Architecture</td>
<td>MVVM+C, RxSwift for bindings and data management</td>
</tr>
<tr>
<td>Views</td>
<td>Code only, Autolayout, no storyboards, no XIBs</td>
</tr>
<tr>
<td>Dependency manager</td>
<td>CocoaPods</td>
</tr>
<tr>
<td>Test frameworks</td>
<td>Quick, Nimble, RxTest</td>
</tr>
<tr>
<td>Other dependencies</td>
<td>RxSwift, RxCocoa, EasyPeasy, RxFirebase, Firebase</td>
</tr>
</tbody>
</table>
<ul>
<li class="has-line-data" data-line-start="10" data-line-end="11">I understood main requirement for List Screen to be a possibility to switch between topics and articles, so I decided to go with UITabBar. I’m not entirely sure if that was original purpose, but it seemed like a good way to show some architecture and coordinator pattern skills,</li>
<li class="has-line-data" data-line-start="11" data-line-end="12">All commits are made directly to master - I’m normally used to gitflow, but for sake of that project creating feature branches, maintaining develop, and release tags seemed like overkill,</li>
<li class="has-line-data" data-line-start="12" data-line-end="13">In models coding keys are exposed intentionally; for majority of cases they can be implicitly computed but based on previous experience I found out that it’s good idea to have them clearly exposed from the start, which provides consistency if any of keys requires modified mapping parameters.</li>
<li class="has-line-data" data-line-start="13" data-line-end="14">Models were generated based on JSON downloaded from firebase, for generating purposes <a href="http://app.quicktype.io">app.quicktype.io</a> was used,</li>
<li class="has-line-data" data-line-start="14" data-line-end="15">Some models were simplified - not all fields were mapped, as their presence seems to be not necessary for sake of this task,</li>
<li class="has-line-data" data-line-start="15" data-line-end="16">Some things got truncated/cut eg. title in article details, this is more UX/UI thing, so I decided not to spend too much time on it,</li>
<li class="has-line-data" data-line-start="16" data-line-end="17">Topic details are very simplified, they don’t even contain viewModels, just use Topic model - reasons are that knowledge of viewModels was presented in articles and there wasn’t much requirements for topics.</li>
<li class="has-line-data" data-line-start="17" data-line-end="18">Image in article details is just a nice addition, so I didn’t optimized it on horizontal orientation so it would be part of scroll view containing text and wouldn’t take that much space, in normal app that would be done,</li>
<li class="has-line-data" data-line-start="18" data-line-end="19">In production app some of constants like margin, fonts, titleBackground color would be extracted into common configuration.</li>
</ul>
