# MoviePedia 기획

- **브랜치 전략 :** git-flow
- **코드 컨벤션 -** [Style Share Guide](https://github.com/StyleShare/swift-style-guide)
- **구조 :** MVVM + CleanArchitecture
- **UI 구현 -** 코드 베이스


## Features
>총 5개의 Main Feature를 구현해보려고 합니다. 각 Main Feature는 몇가지 sub feature들을 가집니다
main, sub feature는 각 1 개의 PR을 의미합니다.



| Feature | 구현 내용 |
| -------- | -------- |
| [F1] Network     |  [F1.1] Network Model 구현 </br> [F1.2] Network Model 테스트     |
|[F2] Home| [F2.1] Movie Service 구현 </br> [F2.2] Home Scene 구현|
|[F3] Search| [F3.1] Search Service 구현 </br> [F3.2] Search Scene 구현|
|[F4] User| [F4.1] Auth(User) Service 구현 + 테스트 </br> [F4.2] 로그인 Scene 구현</br>  [F4.3] Personal Info Scene 구현 </br> [F4.4] 좋아요, 저장, 즐겨찾기, 리스트 기능 구현|
|[F5] Review| [F5.1] Review Service 구현 </br> [F5.2] Movie Review List Scene 구현|


## Feature - 자세한 구현 사항

#### [F1] Network
- [F1.1] Network Model 구현

    > Servie 구현을 위한 네트워크 모델
- [F1.2] Network Model 테스트

#### [F2] Home
- [F2.1] Movie Service 구현 ( + Entity 생성 )

    > tmdb에서 제공하는 인기, 추천, 랭킹, 현재 상영중, 곧 개봉, 최신 카테고리들을 제공하는 서비스 구현
- [F2.2] Home Scene 구현
    - UI 구현 ( UICollectionview, DiffableDataSource, Compositional layout)
        - Single Movie Cell
        - List Cell
        - Video Cell
        - 등 ...
    > 카테고리별 컨텐츠 구현
- [F2.3] Movie Detail Scene 구현
    - Movie Image Info View
    - Movie Rating View ( + Animation )
    - Video List (Collectionview, Cell)
    - Review List (Collectionview, Cell)
    - Keyword List (CollectionView, Cell)
    - People List (Collectionview, Cell)
    - Similar Movie List 
    > 영화 정보, 예고편, 키워드, 출연, 비슷한 영화등을 담는 뷰 구현
    
- [F2.4] 컨텐츠 Cell Detail Scene
    > 특정 카테고리 안내 cell 터치시 보여줄 리스트 형태의 뷰 구현

#### [F3] Search
- [F3.1] Search Service 구현
- [F3.2] Search Scene 구현
    - Search View 구현
    - filter category View 구현
    > 서치 기능 구현 및 필터 기능 

#### [F4] Auth
- [F4.1] Auth Service 구현 + 테스트
- [F4.2] 로그인 Scene 구현
- [F4.3] Personal Info Scene 구현
- [F4.4] 좋아요, 저장, 즐겨찾기, 리스트 기능 구현

#### [F5] Review
- [F5.1] Review Service 구현
- [F5.2] Movie Review List Scene 구현


## 대략적인 컨셉 스크린샷

> 앱 스토어 UI를 참고했습니다.

| Home | Home Cell Detail | Movie Detail |
| -------- | -------- | -------- |
| <img src="https://i.imgur.com/SwUk7LY.png" width="300px"/>     |  <img src="https://i.imgur.com/m9fQXKO.jpg" width="300px"/>  |   <img src="https://i.imgur.com/ooWsjiv.png" width="300px"/>  |

